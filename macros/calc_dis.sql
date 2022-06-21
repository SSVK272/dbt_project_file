{% macro calc_dis(mkseg,p) %}
    {% set seg=['AUTOMOBILE','MACHINERY'] %} 
    {% if mkseg in seg %}
        {{ return(p*0.12) }}
    {% else %}
        {{ return(p*0.04) }}
    {% endif %}
    
{% endmacro %}
