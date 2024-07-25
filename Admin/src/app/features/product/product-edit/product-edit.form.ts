import { FormlyFieldConfig } from "@ngx-formly/core";
import { FORMLY_INPUT, FORMLY_SELECT, FORMLY_TEXT_AREA } from "../../../formly/formly.config";
import { KeyFilterType } from "../../../enums/p-key-filter.type";

export function ProductDetailFields(): FormlyFieldConfig[] {
    return [
        {
            fieldGroupClassName: 'row',
            fieldGroup: [
                {
                    className: 'col-6',
                    key: 'nameProduct',
                    type: FORMLY_INPUT.name,
                    props: {
                        label: 'Tên Sản Phẩm',
                        required: true
                    }
                },
                {
                    className: 'col-6',
                    key: 'price',
                    type: FORMLY_INPUT.name,
                    props: {
                        label: 'Giá Tiền',
                        required: true,
                        keyFilter: KeyFilterType.money
                    }
                },
                {
                    className: 'col-6',
                    key: 'quantity',
                    type: FORMLY_INPUT.name,
                    props: {
                        label: 'Số Lượng',
                        required: true,
                        keyFilter: KeyFilterType.int
                    }
                },
                {
                    className: 'col-6',
                    key: 'cateid',
                    type: FORMLY_SELECT.name,
                    props: {
                        label: 'Loại Sản Phẩm',
                        searchable: true
                    },
                    expressions: {
                        'props.options': "formState.optionList.categories"
                    }
                },
                {
                    className: 'col-12',
                    key: 'includeIdForEdit',
                    type: FORMLY_SELECT.name,
                    props: {
                        label: 'Sản Phẩm Bao Gồm',
                        multiple: true,
                        searchable: true
                    },
                    expressions: {
                        'props.options': "formState.optionList.products"
                    }
                },
                {
                    className: 'col-12',
                    key: 'descrip',
                    type: FORMLY_INPUT.name,
                    props: {
                        label: 'Mô Tả',
                    }
                },
                {
                    className: 'col-12',
                    key: 'img',
                    type: FORMLY_INPUT.name,
                    props: {
                        label: 'Link Ảnh SP',
                        required: true,
                    }
                },
            ]
        }
    ]
}