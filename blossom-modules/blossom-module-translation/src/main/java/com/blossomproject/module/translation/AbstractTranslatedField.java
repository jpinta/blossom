package com.blossomproject.module.translation;

import com.blossomproject.core.common.entity.AbstractEntity;

import javax.persistence.MappedSuperclass;
import java.util.List;

@MappedSuperclass
public abstract class AbstractTranslatedField<ENTITY extends AbstractTranslation> extends AbstractEntity {

    private List<ENTITY> translations;

    public List<ENTITY> getTranslations() {
        return translations;
    }

    public void setTranslations(List<ENTITY> translations) {
        this.translations = translations;
    }
}
