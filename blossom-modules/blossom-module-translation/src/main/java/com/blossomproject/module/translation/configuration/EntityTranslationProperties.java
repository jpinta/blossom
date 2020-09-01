package com.blossomproject.module.translation.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import java.util.List;
import java.util.Locale;

@Configuration
@ConfigurationProperties(prefix = "blossom.entity")
public class EntityTranslationProperties {
    private List<Locale> translations;

    public List<Locale> getTranslations() {
        return translations;
    }

    public void setTranslations(List<Locale> translations) {
        this.translations = translations;
    }
}
