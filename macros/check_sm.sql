{% macro chk_sm(sm) %}
    {% set modes=["AIR","REG AIR","SHIP"] %}
    {% if sm in modes %}
        'Y'
    {% elif sm in modes %}
        'Y'
    {% elif sm in modes %}
        'Y'
    {% else %}
        'N' 
    {% endif %}
{% endmacro %}
