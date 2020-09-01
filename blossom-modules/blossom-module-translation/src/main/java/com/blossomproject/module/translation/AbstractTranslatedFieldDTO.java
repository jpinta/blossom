package com.blossomproject.module.translation;

import com.blossomproject.core.common.dto.AbstractDTO;

import java.util.List;
import java.util.Objects;

public abstract class AbstractTranslatedFieldDTO<DTO extends AbstractTranslationDTO> extends AbstractDTO {

    private List<DTO> translations;

    public AbstractTranslatedFieldDTO() {

    }

    public List<DTO> getTranslations() {
        return translations;
    }

    public void setTranslations(List<DTO> translations) {
        this.translations = translations;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        AbstractTranslatedFieldDTO that = (AbstractTranslatedFieldDTO) o;
        return Objects.equals(translations, that.translations);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), translations);
    }
}
