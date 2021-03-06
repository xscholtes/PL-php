--
-- Testing composite type arguments
--

CREATE TABLE employee (
	name text,
	basesalary integer,
	bonus integer
);

CREATE FUNCTION empcomp(employee) RETURNS integer
LANGUAGE plphp AS $$
	return $args[0]['basesalary'] + $args[0]['bonus'];
$$;

INSERT INTO employee VALUES('plphp', 11, 22);
INSERT INTO employee VALUES('this is a very long name for a person really, but who cares?', 142857 * 3, 142857 * 4);
INSERT INTO employee VALUES('Josh Drake', 150000, 300000);

SELECT name, empcomp(employee) FROM employee;


CREATE TYPE php_complex AS (
	real	float,
	imag	float
);

CREATE FUNCTION sum(php_complex, php_complex) RETURNS php_complex
LANGUAGE plphp AS $$
	$ret['real'] = $args[0]['real'] + $args[1]['real'];
	$ret['imag'] = $args[0]['imag'] + $args[1]['imag'];
	return $ret;
$$;

SELECT sum(row(3, 5)::php_complex, row(10, 20)::php_complex);

CREATE OR REPLACE FUNCTION multiply(php_complex, float) RETURNS php_complex
LANGUAGE plphp AS $$
	return array('real' => $args[0]['real'] * $args[1],
		     'imag' => $args[0]['imag'] * $args[1]);
$$;

SELECT multiply(row(15.2, 22.9), 3.1);
