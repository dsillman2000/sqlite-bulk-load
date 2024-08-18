create table parsed_data as

with indexed_lines as (
   select
      rowid,
      content
   from data
),

open_brackets as (
   select
      rowid,
      row_number() over (order by rowid) as open_id,
      content
   from indexed_lines
   where content like '%{%'
),

close_brackets as (
   select
      rowid,
      row_number() over (order by rowid) as close_id,
      content
   from indexed_lines
   where content like '%}%'
),

bracket_pairs as (
   select
      open_brackets.rowid as open_row,
      close_brackets.rowid as close_row,
      open_brackets.open_id as pair_id
   from open_brackets
   join close_brackets 
   on open_brackets.open_id = close_brackets.close_id
),

bracket_contents as (
   select
      bracket_pairs.pair_id,
      indexed_lines.content,
      indexed_lines.rowid
   from indexed_lines
   left join bracket_pairs 
   on indexed_lines.rowid between bracket_pairs.open_row and bracket_pairs.close_row
   where bracket_pairs.pair_id is not null
),

collapsed_brackets as (
   select
      pair_id,
      group_concat(content, ' ') as content
   from bracket_contents
   group by pair_id
),

cleaned_objects as (
   select
      pair_id,
      json(trim(content, ",")) as content
   from collapsed_brackets
)

select
   pair_id,
   json_extract(content, '$.userId') as user_id,
   json_extract(content, '$.title') as title,
   json_extract(content, '$.body') as body
from cleaned_objects;