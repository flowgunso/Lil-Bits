# Timer with splits 0.1

Set a timer, with or without splits, in minutes. Splits and timer rings a tune.

``python __main__.py 10 -s 1`` Start a 10mn timer with splits every minutes.

``python __main__.py 60 -s 10`` Start a 60mn timer with splits every 10mn.


## TODO
- parse time units (hours, minutes, secondes) as letters within arguments (h, mn, s).
- split into files, function and class for readability, maintenance and improvements.
- split must not be grater than total (and should be a divisor ? no, p^rint warning if not divisor, last split will last less)
