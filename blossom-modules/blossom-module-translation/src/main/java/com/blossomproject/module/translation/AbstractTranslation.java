package com.blossomproject.module.translation;

import com.blossomproject.core.common.entity.AbstractEntity;
import com.blossomproject.core.common.entity.converter.LocaleConverter;

import javax.persistence.Column;
import javax.persistence.Convert;
import javax.persistence.Lob;
import javax.persistence.MappedSuperclass;
import java.util.Locale;

@MappedSuperclass
public abstract class AbstractTranslation extends AbstractEntity {


    @Column(name = "text")
    @Lob
    private String text;

    @Convert(converter = LocaleConverter.class)
    @Column(name = "locale", length = 5)
    private Locale locale;

    public AbstractTranslation() {
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
}
