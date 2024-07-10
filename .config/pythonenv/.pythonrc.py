def fmt(value, decimal_places=2):
    format_string = "{:,.%df}" % decimal_places
    formatted_value = format_string.format(value)
    return formatted_value
