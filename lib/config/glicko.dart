import 'dart:math';

const num WIN = 1.0;
const num DRAW = 0.5;
const num LOSS = 0.0;

const num MU = 1500;
const num PHI = 350;
const num SIGMA = 0.06;
const num TAU = 1.0;
const num EPSILON = 0.000001;

class Rating {
  num mu, phi, sigma;
  Rating({this.mu = MU, this.phi = PHI, this.sigma = SIGMA});

  @override
  String toString() =>
      'Rating(mu: ${mu.toStringAsFixed(3)}, phi: ${phi.toStringAsFixed(3)}, sigma: ${sigma.toStringAsFixed(3)})';
}

class Glicko2 {
  num mu;
  num phi;
  num sigma;
  num tau;
  num epsilon;

  Glicko2({
    this.mu = MU,
    this.phi = PHI,
    this.sigma = SIGMA,
    this.tau = TAU,
    this.epsilon = EPSILON,
  });

  Rating createRating({num? mu, num? phi, num? sigma}) {
    mu ??= this.mu;
    phi ??= this.phi;
    sigma ??= this.sigma;
    return Rating(mu: mu, phi: phi, sigma: sigma);
  }

  Rating scaleDown(Rating rating, [num ratio = 173.7178]) {
    num mu = (rating.mu - this.mu) / ratio;
    num phi = rating.phi / ratio;
    return createRating(mu: mu, phi: phi, sigma: rating.sigma);
  }

  Rating scaleUp(Rating rating, [num ratio = 173.7178]) {
    num mu = rating.mu * ratio + this.mu;
    num phi = rating.phi * ratio;
    return createRating(mu: mu, phi: phi, sigma: rating.sigma);
  }

  num reduceImpact(Rating rating) {
    // The original form is `g(RD)`. This function reduces the impact of
    // games as a function of an opponent's RD.
    return 1.0 / sqrt(1 + (3 * rating.phi * rating.phi) / (pi * pi));
  }

  num expectScore(Rating rating, Rating otherRating, num impact) {
    return 1.0 / (1 + exp(-impact * (rating.mu - otherRating.mu)));
  }

  num determineSigma(Rating rating, num difference, num variance) {
// Determines new sigma.
    num phi = rating.phi;
    num differenceSquared = pow(difference, 2);
// 1. Let a = ln(s^2), and define f(x)
    num alpha = log(pow(rating.sigma, 2));

    num f(num x) {
/* This function is twice the conditional log-posterior density of
* phi, and is the optimality criterion.
*/
      num tmp = pow(phi, 2) + variance + exp(x);
      num a = exp(x) * (differenceSquared - tmp) / (2 * pow(tmp, 2));
      num b = (x - alpha) / pow(tau, 2);
      return a - b;
    }

// 2. Set the initial values of the iterative algorithm.
    num a = alpha;
    num b;
    if (differenceSquared > pow(phi, 2) + variance) {
      b = log(differenceSquared - pow(phi, 2) - variance);
    } else {
      int k = 1;
      while (f(alpha - k * sqrt(pow(tau, 2))) < 0) {
        k++;
      }
      b = alpha - k * sqrt(pow(tau, 2));
    }

// 3. Let fA = f(A) and f(B) = f(B)
    num f_a = f(a), f_b = f(b);

// 4. While |B-A| > e, carry out the following steps.
// (a) Let C = A + (A - B)fA / (fB-fA), and let fC = f(C).
// (b) If fCfB < 0, then set A <- B and fA <- fB; otherwise, just set
// fA <- fA/2.
// (c) Set B <- C and fB <- fC.
// (d) Stop if |B-A| <= e. Repeat the above three steps otherwise.
    while ((b - a).abs() > epsilon) {
      num c = a + (a - b) * f_a / (f_b - f_a);
      num f_c = f(c);
      if (f_c * f_b < 0) {
        a = b;
        f_a = f_b;
      } else {
        f_a /= 2;
      }
      b = c;
      f_b = f_c;
    }

// 5. Once |B-A| <= e, set s' <- e^(A/2)
    return pow(e, a / 2);
  }

  Rating rate(Rating rating, List<Tuple<num, Rating>> series) {
    // Step 2. For each player, convert the rating and RD's onto the
    //         Glicko-2 scale.
    rating = scaleDown(rating);

    // Step 3. Compute the quantity v. This is the estimated variance of the
    //         team's/player's rating based only on game outcomes.
    // Step 4. Compute the quantity difference, the estimated improvement in
    //         rating by comparing the pre-period rating to the performance
    //         rating based only on game outcomes.
    num varianceInv = 0;
    num difference = 0;
    if (series.isEmpty) {
      // If the team didn't play in the series, do only Step 6
      final phiStar = sqrt(pow(rating.phi, 2) + pow(rating.sigma, 2));
      return scaleUp(
          createRating(mu: rating.mu, phi: phiStar, sigma: rating.sigma));
    }
    for (final scoreAndOtherRating in series) {
      final actualScore = scoreAndOtherRating.item1;
      final otherRating = scaleDown(scoreAndOtherRating.item2);
      final impact = reduceImpact(otherRating);
      final expectedScore = expectScore(rating, otherRating, impact);
      varianceInv += pow(impact, 2) * expectedScore * (1 - expectedScore);
      difference += impact * (actualScore - expectedScore);
    }
    difference /= varianceInv;
    final variance = 1 / varianceInv;

    // Step 5. Determine the new value, Sigma', ot the sigma. This
    //         computation requires iteration.
    final sigma = determineSigma(rating, difference, variance);

    // Step 6. Update the rating deviation to the new pre-rating period
    //         value, Phi*.
    final phiStar = sqrt(pow(rating.phi, 2) + pow(sigma, 2));

    // Step 7. Update the rating and RD to the new values, Mu' and Phi'.
    final phi = 1 / sqrt(1 / pow(phiStar, 2) + 1 / variance);
    final mu = rating.mu + pow(phi, 2) * (difference / variance);

    // Step 8. Convert ratings and RD's back to original scale.
    return scaleUp(createRating(mu: mu, phi: phi, sigma: sigma));
  }

  Tuple<Rating, Rating> rate1vs1(Rating rating1, Rating rating2,
      {bool drawn = false}) {
    return Tuple(rate(rating1, [Tuple(drawn ? DRAW : WIN, rating2)]),
        rate(rating2, [Tuple(drawn ? LOSS : WIN, rating1)]));
  }

  num quality1vs1(Rating rating1, Rating rating2) {
    final expectedScore1 = expectScore(rating1, rating2, reduceImpact(rating1));
    final expectedScore2 = expectScore(rating2, rating1, reduceImpact(rating2));
    final expectedScore = (expectedScore1 + expectedScore2) / 2;
    return 2 * (0.5 - (0.5 - expectedScore).abs());
  }
}

class Tuple<T1, T2> {
  final T1 item1;
  final T2 item2;

  const Tuple(this.item1, this.item2);

  @override
  String toString() => '($item1, $item2)';
}
