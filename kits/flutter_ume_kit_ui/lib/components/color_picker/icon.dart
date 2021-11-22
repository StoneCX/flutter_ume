const iconData =
    r'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';