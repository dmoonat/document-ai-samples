LOCATION=us
PROJECT_ID=techpuzzle-docai
PROCESSOR_ID=7c2cbdc69385a5c2
submit:
	echo -n '{"document": {"mimeType": "image/png","content": "' > docai_request.json
	base64 --wrap=0 "Sample Invoice 1.png" >> docai_request.json
	echo -n '"}}' >> docai_request.json
	curl -X POST \
		-H "Authorization: Bearer "$(shell gcloud auth application-default print-access-token) \
		-H "Content-Type: application/json; charset=utf-8" \
		-d @docai_request.json \
		https://$(LOCATION)-documentai.googleapis.com/v1beta3/projects/$(PROJECT_ID)/locations/$(LOCATION)/processors/$(PROCESSOR_ID):process > result.json
	rm -f docai_request.json
	echo "See result.json for results"
