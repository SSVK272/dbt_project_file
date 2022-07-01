
{% macro rupee_to_dollars(column_name, precision=2) %}
    ({{ column_name }} / 61.06)::numeric(16,{{ precision }})
{% endmacro %}
