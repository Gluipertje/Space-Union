extends HTTPRequest

func _ready():
	connect("request_completed", self, "_http_request_completed")

	# Perform the HTTP request. The URL below returns some JSON as of writing.
	var error = request("https://space-union-api.herokuapp.com/users", [], true, HTTPClient.METHOD_POST, JSON.print("username=bruh&password=cringe"))
	if error != OK:
		push_error("An error occurred in the HTTP request.")


# Called when the HTTP request is completed.
func _http_request_completed(result, response_code, headers, body):
	var response = parse_json(body.get_string_from_utf8())
	print(response)
