package io.openruntimes.java;

import org.rapidoid.http.Req;

import java.util.Map;
import java.util.ArrayList;

public class RuntimeContext {
    public RuntimeRequest req;
    public RuntimeResponse res;

    public ArrayList<String> _logs = new ArrayList<String>();
    public ArrayList<String> _errors = new ArrayList<String>();

    public RuntimeContext(
            RuntimeRequest req,
            RuntimeResponse res
    ) {
        this.req = req;
        this.res = res;
    }

    public void log(Object message) {
        this._logs.add(message.toString());
    }

    public void error(Object message) {
        this._errors.add(message.toString());
    }
}


