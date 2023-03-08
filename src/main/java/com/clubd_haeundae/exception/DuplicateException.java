package com.clubd_haeundae.exception;

public class DuplicateException extends RuntimeException {

    public DuplicateException(String msg) {
        super(msg);
    }

    public DuplicateException() {
        super("Duplicated");
    }
}
