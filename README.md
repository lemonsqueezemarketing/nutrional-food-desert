
# 📊 Visualizing Nutritional Food Deserts: Project Summary & Instructions

---

## 🧠 Project Vision
This project aims to visualize the concept of **nutritional food deserts**, focusing on how access to healthy food varies by location. Inspired by "Banking Desert" studies, the goal is to show how lack of access to nutritious options may correlate with **health outcomes** such as **diabetes** and **high blood pressure**.

### ✅ Core Objectives:
1. Analyze restaurants, convenience stores, and grocery stores to assess nutrition quality of food options.
2. Assign each location a **Nutritional Score** (from 0 = poor to 5 = excellent).
3. Map access to nutritious food geographically by ZIP code.
4. Visualize health outcome data (e.g., diabetes prevalence) by area.
5. Study the correlation between poor health outcomes and nutritional access.

---

## 🗺️ Planned Visualizations

### 1. Restaurant Nutritional Score Map
- **Type**: Geographic scatter or heat map
- **Color**: Red (0) to Green (5)
- **Location**: U.S. focus, starting with Georgia and Atlanta

### 2. Convenience Store Nutritional Score Map
- Similar layout as restaurants, but focuses on gas stations and corner stores

### 3. Grocery Store Nutritional Score Map
- Identifies if nutritious options are more available through grocery chains

### 4. Health Outcomes Heat Map
- **Type**: Choropleth / heat map
- **Metric**: Prevalence of diabetes, high blood pressure
- **Color**: Blue (low) to Red (high)

---

## 🧰 Toolchain for Implementation
These visualizations will be built first as **PNG mockups**, then implemented in:
- 📊 Google Sheets
- 🐍 Python (Plotly)
- 📈 Power BI
- 📉 Tableau

---

## 🛠️ Instructions for Implementation

### Step-by-Step:
1. Create **dummy data** for ZIP codes, coordinates, and nutrition scores
2. Use a **geographic base map** (USA → Georgia → Atlanta)
3. Overlay **points** or **choropleths** with color-coded nutrition scores
4. Use the **RdYlGn color scale** for accessibility
5. Add **ZIP code labels** for context
6. Export the map as **PNG** or **SVG**

---

## 🎨 Design Notes
- Use clear titles, legends, and labels
- Ensure all visual elements are readable and non-overlapping
- Maps should approximate state/city boundaries for geographic accuracy
- Consider colorblind-safe palettes
- Align design with the data literacy level of the audience
