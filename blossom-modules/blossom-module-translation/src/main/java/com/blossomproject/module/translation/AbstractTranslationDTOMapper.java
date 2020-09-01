package com.blossomproject.module.translation;

import com.blossomproject.core.common.mapper.AbstractDTOMapper;
import com.google.common.base.Preconditions;

public abstract class AbstractTranslationDTOMapper<ENTITY extends AbstractTranslation, DTO extends AbstractTranslationDTO> extends AbstractDTOMapper<ENTITY,DTO> {

    @Override
    protected void mapDtoCommonFields(ENTITY entity, DTO dto) {
        Preconditions.checkArgument(dto != null);
        Preconditions.checkArgument(entity != null);
        entity.setLocale(dto.getLocale());
        entity.setText(dto.getText());
        super.mapDtoCommonFields(entity, dto);
    }

    @Override
    protected void mapEntityCommonFields(DTO dto, ENTITY entity) {
        Preconditions.checkArgument(dto != null);
        Preconditions.checkArgument(entity != null);
        dto.setLocale(entity.getLocale());
        dto.setText(entity.getText());
        super.mapEntityCommonFields(dto, entity);
    }
}
