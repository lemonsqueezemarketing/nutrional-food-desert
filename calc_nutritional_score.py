def compute_nutrition_score(
    calories, protein_g, carbs_g, fat_g, cholesterol_mg, sodium_mg,
    # per-meal reference values (adjust if needed)
    T_cal=700, T_protein=25, T_carb=90, T_fat=30, T_chol=100, T_sodium=800,
    # weights
    w_cal=1.0, w_carb=0.8, w_fat=1.0, w_chol=0.5, w_sodium=1.2,
    alpha=0.35        # protein “bonus” weight
):
    """Return a nutritional score from 0 (worst) to 5 (best)."""
    # Normalize penalties (0=good, 1=worst)
    pen_cal    = min(calories / T_cal, 1.0)
    pen_carb   = min(carbs_g / T_carb, 1.0)
    pen_fat    = min(fat_g / T_fat, 1.0)
    pen_chol   = min(cholesterol_mg / T_chol, 1.0)
    pen_sodium = min(sodium_mg / T_sodium, 1.0)

    # Protein bonus (0=low, 1=meets/exceeds target)
    bonus_protein = min(protein_g / T_protein, 1.0)

    # Weighted penalty average
    denom = w_cal + w_carb + w_fat + w_chol + w_sodium
    penalty = (
        w_cal*pen_cal + w_carb*pen_carb + w_fat*pen_fat
        + w_chol*pen_chol + w_sodium*pen_sodium
    ) / denom

    # Quality index: reward protein, subtract penalties
    quality = alpha * bonus_protein + (1 - alpha) * (1 - penalty)
    quality = max(0.0, min(1.0, quality))

    return round(5 * quality, 2)