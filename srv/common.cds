namespace scp.cloud;

using IncidentService as service from './incidentservice';
using {cuid} from '@sap/cds/common';

annotate cuid with {
    ID @(
        title : '{i18n>ID}',
        UI.HiddenFilter,
        Core.Computed
    );
}


annotate service.Incidents with {
    ID                 @UI.Hidden : true;
    assignedIndividual @UI.Hidden : true;
    identifier         @(Common.FieldControl : identifierFieldControl);
};

annotate service.Incidents with {
    incidentStatus @Common : {
        Text            : incidentStatus.name,
        TextArrangement : #TextOnly,
        ValueListWithFixedValues
    };
    category       @Common : {
        Text            : category.name,
        TextArrangement : #TextOnly,
        ValueListWithFixedValues
    };
    priority       @Common : {
        Text            : priority.name,
        TextArrangement : #TextOnly,
        ValueListWithFixedValues
    };
};

annotate service.Category with {
    code @Common : {
        Text            : name,
        TextArrangement : #TextOnly
    }    @title :  '{i18n>Category}'
};

annotate service.Priority with {
    code @Common : {
        Text            : name,
        TextArrangement : #TextOnly
    }    @title :  '{i18n>Priority}'
};

annotate service.IncidentStatus with {
    code @Common : {
        Text            : name,
        TextArrangement : #TextOnly
    }    @title :  '{i18n>IncidentStatus}'
};

//add contact card annotation
annotate service.Individual with @(Communication.Contact : {
    fn  : businessPartner.BusinessPartnerFullName,
    adr : [{
        type     : #work,
        code     : businessPartnerAddress.PostalCode,
        street   : businessPartnerAddress.StreetName,
        building : businessPartnerAddress.HouseNumber,
        country  : businessPartnerAddress.Country,
        locality : businessPartnerAddress.CityName
    }]
});
