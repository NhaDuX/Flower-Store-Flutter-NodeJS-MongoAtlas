import { FormlyFieldConfig } from "@ngx-formly/core";
import { FORMLY_INPUT, FORMLY_SELECT, FORMLY_TEXT_AREA } from "../../../formly/formly.config";
import { KeyFilterType } from "../../../enums/p-key-filter.type";

export function AccountDetailFields(): FormlyFieldConfig[] {
    return [
        {
            fieldGroupClassName: 'row',
            fieldGroup: [
                {
                    className: 'col-6',
                    key: 'name',
                    type: FORMLY_INPUT.name,
                    props: {
                        label: 'Tên',
                        required: true
                    }
                },
                {
                    className: 'col-6',
                    key: 'email',
                    type: FORMLY_INPUT.name,
                    props: {
                        label: 'Email',
                        required: true,
                    }
                },
                {
                    className: 'col-6',
                    key: 'phone',
                    type: FORMLY_INPUT.name,
                    props: {
                        label: 'Số điện thoại',
                        required: true,
                        keyFilter: KeyFilterType.int
                    }
                },
                {
                    className: 'col-6',
                    key: 'password',
                    type: FORMLY_INPUT.name,
                    props: {
                        label: 'Mật Khẩu',
                        required: true,
                    },
                    expressions: {
                        'props.disabled': 'formState.editMode'
                    }
                },
            ]
        }
    ]
}