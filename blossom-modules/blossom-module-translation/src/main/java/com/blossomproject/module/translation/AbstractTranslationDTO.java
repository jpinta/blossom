package com.blossomproject.module.translation;

import com.blossomproject.core.common.dto.AbstractDTO;

import java.util.Locale;
import java.util.Objects;

public abstract class AbstractTranslationDTO extends AbstractDTO {

    private String text;
    private Locale locale;

    public AbstractTranslationDTO() {

    }

    public AbstractTranslationDTO(String text, Locale locale) {
        this.text = text;
        this.locale = locale;
    }

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

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        AbstractTranslationDTO that = (AbstractTranslationDTO) o;
        return Objects.equals(text, that.text) &&
                Objects.equals(locale, that.locale);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), text, locale);
    }
}
