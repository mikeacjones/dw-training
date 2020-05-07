%dw 2.0
output application/json

import dw::modules::Currency
import dw::modules::Currency as Curr
import adjustedFor as adj4, xes as ExchangeRates from dw::modules::Currency

var theTotalSeats = 500

fun getTotalSeats(pt) = if (
	(pt contains "737") or
	(pt contains "707") or
	(pt contains "727")
) 150 else 300

var getTotalSeatsL = (pt) -> do {
	var pn = pt[-3 to -1] as Number
	---
	if (pn == 737 or pn == 707 or pn == 727) 155 else 305
}

var xes = {
	USD: 1.0,
	EUR: 0.9,
	CAD: 1.3,
	GBP: 0.8,
	INR: 72,
	MXN: 24
}

var adjustedFor = (p, c) -> 10

---
//payload..*return map ($ ++ { totalSeats: 400 })

payload..*return map {
	($ - "planeType"),
	planeType: $.planeType replace /Boing/ with "Boeing",
	totalSeats: getTotalSeatsL($.planeType),
//	(xes mapObject ("price$($$)"): $.price adjustedFor $$),
	priceEUR: adjustedFor($.price, "EUR"),
	priceCAD: $.price adjustedFor "CAD",
	priceGBP: $.price dw::modules::Currency::adjustedFor "GBP",
	priceINR: $.price Currency::adjustedFor "INR",
	priceMXN: $.price Curr::adjustedFor "MXN",
	priceUSD: $.price adj4 "USD"
}