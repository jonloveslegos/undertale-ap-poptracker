import json
import os.path

with open(os.path.join(os.path.curdir, "locations/sanity.json"), "w") as f:
    f.writelines([
                '[\n',
                '{\n',
                '"name": "Sanity",\n',
                '"access_rules": [\n',
                '],\n',
                '"children": [\n{}'
    ])
    for region in ["Ruins", "Snowdin", "Waterfall", "Hotland"]:
        amount_to_add = 40
        if region == "Ruins":
            amount_to_add = 20
        if region == "Snowdin":
            amount_to_add = 16
        if region == "Waterfall":
            amount_to_add = 18
        for count in range(amount_to_add):
            f.writelines([
                ',\n{\n',
                '"name": "'+region+' Kill '+str(count+1)+'",\n',
                '"access_rules": [\n',
                '["$has_more_then_n_kills|'+region.lower()+'_kills|'+str(count+1)+'", "'+region.lower()+'"]\n',
                '],\n',
                '"visibility_rules": [["killsanity_enabled", "$is_route|all_routes"], ["killsanity_enabled", "$is_route|genocide"]],\n',
                '"sections": [\n',
                '{\n',
                '"item_count": 1\n',
                '}\n',
                '],\n',
                '"map_locations": [\n',
                "{\n",
                '"map": "'+region.lower()+'",\n'
            ])
            if count >= 20:
                f.writelines([
                    '"x": '+str(60+(60*(count-20)))+',\n',
                    '"y": 180\n',
                    "}\n",
                    "]\n",
                    "}"
                ])
            else:
                f.writelines([
                    '"x": '+str(60+(60*count))+',\n',
                    '"y": 120\n',
                    "}\n",
                    "]\n",
                    "}"
                ])
        for count in range(100):
            f.writelines([
                ',\n{\n',
                '"name": "'+region+' Spare '+str(count+1)+'",\n',
                '"access_rules": [\n',
                '["$has_more_then_n_spares|'+region.lower()+'_spares|'+str(count+1)+'", "'+region.lower()+'"]\n',
                '],\n',
                '"visibility_rules": [["sparesanity_enabled", "$is_route|neutral", "$has_more_then_n_consumable|spare_sanity_max|'+str(count+1)+'"], ["sparesanity_enabled", "$is_route|all_routes", "$has_more_then_n_consumable|spare_sanity_max|'+str(count+1)+'"], ["sparesanity_enabled", "$is_route|pacifist", "$has_more_then_n_consumable|spare_sanity_max|'+str(count+1)+'"]],\n',
                '"sections": [\n',
                '{\n',
                '"item_count": 1\n',
                '}\n',
                '],\n',
                '"map_locations": [\n',
                "{\n",
                '"map": "'+region.lower()+'",\n'
            ])
            if count >= 80:
                f.writelines([
                    '"x": ' + str(60 + (60 * (count - 80))) + ',\n',
                    '"y": 480\n',
                    "}\n",
                    "]\n",
                    "}"
                ])
            elif count >= 60:
                f.writelines([
                    '"x": ' + str(60 + (60 * (count - 60))) + ',\n',
                    '"y": 420\n',
                    "}\n",
                    "]\n",
                    "}"
                ])
            elif count >= 40:
                f.writelines([
                    '"x": '+str(60+(60*(count-40)))+',\n',
                    '"y": 360\n',
                    "}\n",
                    "]\n",
                    "}"
                ])
            elif count >= 20:
                f.writelines([
                    '"x": '+str(60+(60*(count-20)))+',\n',
                    '"y": 300\n',
                    "}\n",
                    "]\n",
                    "}"
                ])
            else:
                f.writelines([
                    '"x": '+str(60+(60*count))+',\n',
                    '"y": 240\n',
                    "}\n",
                    "]\n",
                    "}"
                ])
    f.writelines([
                '\n]\n',
                '}\n',
                ']'
    ])

with open(os.path.join(os.path.curdir, "temp_location_mapping.json"), "w") as f:
    f.writelines([
        'LOCATION_MAPPING = {\n',
    ])
    for count in range(1, 20):
        f.writelines([
            '    ['+str(count+79901)+'] = {"@Levels/LV'+str(count+1)+'/"},\n',
        ])
        f.writelines([
            '    ['+str(count+79901)+'] = {"@HP/LV'+str(count+1)+'/"},\n',
        ])
        f.writelines([
            '    ['+str(count+79901)+'] = {"@ATK/LV'+str(count+1)+'/"},\n',
        ])
        if count+1 in [5, 9, 13, 17]:
            f.writelines([
                '    ['+str(count+79901)+'] = {"@DEF/LV'+str(count+1)+'/"},\n',
            ])
    for region in ["Ruins", "Snowdin", "Waterfall", "Hotland"]:
        amount_to_add = 40
        extra_to_id = 79173
        extra_to_spare = 78313
        if region == "Ruins":
            amount_to_add = 20
            extra_to_id = 79119
            extra_to_spare = 78013
        if region == "Snowdin":
            amount_to_add = 16
            extra_to_id = 79139
            extra_to_spare = 78113
        if region == "Waterfall":
            amount_to_add = 18
            extra_to_id = 79155
            extra_to_spare = 78213
        for count in range(amount_to_add):
            f.writelines([
                '    ['+str(count+extra_to_id)+'] = {"@Sanity/'+region+' Kill '+str(count+1)+'/"},\n',
            ])
        for count in range(100):
            f.writelines([
                '    ['+str(count+extra_to_spare)+'] = {"@Sanity/'+region+' Spare '+str(count+1)+'/"},\n',
            ])
    f.writelines([
        '}\n',
    ])
