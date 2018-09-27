extends Node

var id = 3
var getUrl = "https://localhost:5001/api/values/get"
var getUrlWithParameter = "https://localhost:5001/api/values/get/" + str(id)
var postUrlWithString = "https://localhost:5001/api/values/postwithstring"
var postUrlWithObject = "https://localhost:5001/api/values/postwithobject"
var putUrl = "https://localhost:5001/api/values/put/" + str(id)
var deleteUrl = "https://localhost:5001/api/values/delete/" + str(id)

var headers = ["Content-Type: application/json"]
var use_ssl = false

# Call Get
func _on_CallGetButton_pressed():call_get(false)

# Call Get with parameter
func _on_CallGetWithIdButton_pressed():call_get(true)

# Call Post with (parameter: string)
func _on_CallPostButton_pressed():
	var data = "This me, Earn!"
	call_post(data)

# Call Post with (parameter: object)
func _on_CallPostWithObjectButton_pressed():
	var data = { "Id": "myId", "Name": "Earn" }
	call_post(data)

func _on_CallPutButton_pressed():
	var data = "This me, Earn! (from put)"
	var query = JSON.print(data)
	$Container/HTTPRequest.request(putUrl, headers, use_ssl, HTTPClient.METHOD_PUT, query)

func _on_CallDeleteButton_pressed():
	$Container/HTTPRequest.request(deleteUrl, headers, use_ssl, HTTPClient.METHOD_DELETE)

func call_get(hasParameter):
	var url
	if(hasParameter): url = getUrlWithParameter
	else: url = getUrl
	$Container/HTTPRequest.request(url, headers, use_ssl, HTTPClient.METHOD_GET)
func call_post(parameter):
	var query = JSON.print(parameter)
	var url
	if(typeof(parameter) == TYPE_STRING): url = postUrlWithString
	else: url = postUrlWithObject
	$Container/HTTPRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)

# Response from server
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	$Container/ResponseLabel.text = "Code: " + str(response_code) + "\nResult: " + str(json.result)