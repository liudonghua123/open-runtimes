import Foundation

class RuntimeResponse {

    func binary(
        _ bytes: Data,
        statusCode: Int = 200,
        headers: [String: String] = [:]
    ) -> RuntimeOutput {
        return RuntimeOutput(
            body: bytes,
            statusCode: statusCode,
            headers: headers
        )
    }

    func text(
        _ body: String,
        statusCode: Int = 200,
        headers: [String: String] = [:]
    ) -> RuntimeOutput {
        if let binaryBody = body.data(using: .utf8) {
            return self.binary(binaryBody, statusCode: statusCode, headers: headers)
        } else {
            return self.binary(Data(), statusCode: statusCode, headers: headers)
        }
    }

    func send(
        _ body: String,
        statusCode: Int = 200,
        headers: [String: String] = [:]
    ) -> RuntimeOutput {
        return self.text(body, statusCode: statusCode, headers: headers)
    }

    func json(
        _ json: [String: Any?],
        statusCode: Int = 200,
        headers: [String: String] = [:]
    ) throws -> RuntimeOutput {
        var outputHeaders = headers
        
        outputHeaders["content-type"] = "application/json"

        let data = try JSONSerialization.data(
          withJSONObject: json
        )

        let text = String(
            data: data,
            encoding: .utf8
        )

        return self.text(text!, statusCode: statusCode, headers: outputHeaders)
    }

    func empty() -> RuntimeOutput {
        return self.text("", statusCode: 204)
    }

    func redirect(
        _ url: String,
        statusCode: Int = 301,
        headers: [String: String] = [:]
    ) -> RuntimeOutput {
        var outputHeaders = headers

        outputHeaders["location"] = url

        return self.text("", statusCode: statusCode, headers: outputHeaders)
    }
}
