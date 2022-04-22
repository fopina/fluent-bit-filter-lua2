dev:
	docker build -f Dockerfile.build -o dist .

run: dev
	cp test.lua dist/
	docker run --rm \
			-v $(PWD)/dist:/myplugin \
			fluent/fluent-bit:1.9.2 \
			/fluent-bit/bin/fluent-bit \
			-f 1 \
			-e /myplugin/flb-filter_lua2.so \
			-i dummy \
			-F lua2 -m '*' -p Script=/myplugin/test.lua -p Call=cb_drop $(EXTRA_ARGS)\
			-o stdout -m '*' \
			-o exit -m '*'

test: EXTRA_ARGS=-q
test: run
