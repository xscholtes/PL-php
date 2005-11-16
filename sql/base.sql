--
-- Base types
--

CREATE FUNCTION php_max (integer, integer) RETURNS integer
STRICT LANGUAGE plphp AS $$
	if ($args[0] > $args[1]) {
		return $args[0];
	} else return $args[1];
$$;

CREATE FUNCTION php_max_null (integer, integer) RETURNS integer
CALLED ON NULL INPUT LANGUAGE plphp AS $$
	if (!isset($args[0])) {
		if (!isset($args[1])) {
			return;
		}
		return $args[1];
	} else if (!isset($args[1])) {
		return $args[0];
	}
        if ($args[0] > $args[1]) {
                return $args[0];
        } else return $args[1];
$$;

SELECT php_max(1, 2);
SELECT php_max(2, 1);
SELECT php_max(-1, -999999999);
SELECT php_max(0, 0);
SELECT php_max(NULL, 0);
SELECT php_max(0, NULL);
SELECT php_max(NULL, NULL);

SELECT php_max_null(NULL, 0);
SELECT php_max_null(0, NULL);
SELECT php_max_null(NULL, NULL);
SELECT php_max_null(1, -2);

CREATE FUNCTION php_str_max (text, text) RETURNS text
STRICT LANGUAGE plphp AS $$
	if ($args[0] > $args[1]) {
		return $args[0];
	}
	return $args[1];
$$;

SELECT php_str_max('foo', 'bar');
SELECT php_str_max($$After the presentation, we headed down to the restaurant in the building for and evening reception with beer, buffet and even a little bingo. Lot's of business cards were exchanged with a variety of PostgreSQL users and developers, and even one of the Firebird team!!$$, ' foo');
SELECT php_str_max('', NULL);

CREATE FUNCTION php_substr(text, int, int) RETURNS text
STRICT LANGUAGE plphp AS $$
	return substr($args[0], $args[1], $args[2]);
$$;

CREATE FUNCTION php_concat(text, text) RETURNS text
STRICT LANGUAGE plphp AS $$
	return $args[0] . $args[1];
$$;

CREATE FUNCTION php_lc(text) RETURNS text
STRICT LANGUAGE plphp AS $$
	return strtolower($args[0]);
$$;

SELECT php_concat(
	php_substr($$On Saturday, we spent a day sight-seeing, mainly in Kamakura where we visted a couple of temples and a very large cast iron Buddha. Lunch was Korean barbeque, following which we took a trip back to Tokyo station on the Shinkansen, or Bullet Train.$$, 16, 25),
	php_lc($$A few beers in the 'Victorian Pub'$$)
);