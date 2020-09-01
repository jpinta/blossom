package com.blossomproject.module.translation;

import java.util.Locale;

public class TranslationForm {
    private String text;
    private Locale locale;

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Locale getLocale() {
        return locale;
    }

    public void setLocale(Locale locale) {
        this.locale = locale;
    }
}
