{% macro calc_dis(mkseg,p) %}
    {% set seg=['AUTOMOBILE','MACHINERY'] %} 
    {% if mkseg in seg %}
        {{ return(price*0.12) }}
    {% else %}
        {{ return(price*0.04) }}
    {% endif %}
    
{% endmacro %}
