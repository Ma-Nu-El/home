import locale

# Set the locale to your default system locale
locale.setlocale(locale.LC_ALL, '')

# Define the function to format currency values
def fmt(value):
    return locale.currency(value, grouping=True)

