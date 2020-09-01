package com.blossomproject.module.translation;

import com.blossomproject.core.common.mapper.AbstractDTOMapper;
import com.google.common.base.Preconditions;

public abstract class AbstractTranslatedFieldDTOMapper<ENTITY extends AbstractTranslatedField, DTO extends AbstractTranslatedFieldDTO> extends AbstractDTOMapper<ENTITY,DTO> {

    private final AbstractTranslationDTOMapper abstractTranslationDTOMapper;

    public AbstractTranslatedFieldDTOMapper(AbstractTranslationDTOMapper abstractTranslationDTOMapper) {
        this.abstractTranslationDTOMapper = abstractTranslationDTOMapper;
    }

    @Override
    protected void mapDtoCommonFields(ENTITY entity, DTO dto) {
        Preconditions.checkArgument(dto != null);
        Preconditions.checkArgument(entity != null);
        entity.setTranslations(abstractTranslationDTOMapper.mapDtos(dto.getTranslations()));
        super.mapDtoCommonFields(entity, dto);
    }

    @Override
    protected void mapEntityCommonFields(DTO dto, ENTITY entity) {
        Preconditions.checkArgument(dto != null);
        Preconditions.checkArgument(entity != null);
        dto.setTranslations(abstractTranslationDTOMapper.mapEntities(entity.getTranslations()));
        super.mapEntityCommonFields(dto, entity);
    }
}
