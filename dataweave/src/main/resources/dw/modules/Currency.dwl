%dw 2.0

var xes = {
	USD: 1.0,
	EUR: 0.9,
	CAD: 1.3,
	GBP: 0.8,
	INR: 72,
	MXN: 24
}

var adjustedFor = (p, c) -> p * xes[c]