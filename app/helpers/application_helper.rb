module ApplicationHelper
  def alert_class(flash_type)
    case flash_type.to_sym
      when :notice
        "alert-success"
      when :alert
        "alert-warning"
      when :error
        "alert-danger"
    end
  end

  # colors from https://tailwindcss.com/docs/customizing-colors#color-palette-reference
  def transaction_category_color(category)
    colors = {
      "Travel" => "#3B82F6",
      "Education" => "#C2410C",
      "Transport" => "#22C55E",
      "Home" => "#A855F7",
      "Sports/Fitness" => "#D946EF",
      "Hobbies" => "#EC4899",
      "Haircut/Beauty" => "#F43F5E",
      "Car" => "#0EA5E9",
      "Gifts" => "#06B6D4",
      "Shopping" => "#14B8A6",
      "Personal" => "#10B981",
      "Work" => "#EAB308",
      "Entertainment" => "#8B5CF6",
      "Groceries" => "#EAB308",
      "Food and Drink" => "#F97316",
      "Bills and Fees" => "#6366F1",
      "Healthcare" => "#EF4444",
      "Other" => "#475569"
    }
    colors.default = "#475569"
    return colors[category]
  end

  def transaction_category_icon(category)
    icons = {
      "Travel" => "plane",
      "Education" => "university",
      "Transport" => "route",
      "Home" => "home",
      "Sports/Fitness" => "dumbbell",
      "Hobbies" => "palette",
      "Haircut/Beauty" => "cut",
      "Car" => "car",
      "Gifts" => "gift",
      "Shopping" => "shopping-cart",
      "Personal" => "user",
      "Work" => "briefcase",
      "Entertainment" => "theater-masks",
      "Groceries" => "shopping-basket",
      "Food and Drink" => "utensils",
      "Bills and Fees" => "file-invoice-dollar",
      "Healthcare" => "heartbeat",
      "Other" => "circle"
    }
    icons.default = "plus"
    return icons[category]
  end
end
