# Load library
library(ggplot2)

# Create 15-row data frame
data <- data.frame(
  Concentration = c(0.001, 0.003, 0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30, 50, 70, 100, 300, 1000),
  Inhibition = c(0.5, 2.0, 8.0, 15.0, 25.0, 38.0, 50.0, 62.0, 75.0, 85.0, 88.0, 90.0, 92.0, 93.5, 94.0)
)

# Create semi-log plot
p <- ggplot(data, aes(x = Concentration, y = Inhibition)) +
  geom_point(size = 2, color = "blue") +                    # Larger points
  geom_smooth(method = "loess", se = TRUE, color = "red") +  # Smooth curve with confidence band
  scale_x_log10(
    breaks = c(0.001, 0.01, 0.1, 1, 10, 100, 1000),        # Custom tick marks
    labels = c("0.001", "0.01", "0.1", "1", "10", "100", "1000")
  ) +
  labs(
    title = "Dose-Response Curve (Log Scale)",
    subtitle = "EC50 ≈ 1 mg/L",
    x = "Concentration (mg/L, log₁₀ scale)",
    y = "% Enzyme Inhibition"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(size = 14, face = "bold"))

# Display plot
print(p)

# Save high-quality image
ggsave("dose_response_15rows.png", p, width = 8, height = 6, dpi = 300)
