<?php

require __DIR__ . '/../vendor/autoload.php';

use React\Http\Response;
use React\Http\StreamingServer;

$counter = 0;
$loop = \React\EventLoop\Factory::create();

$server = new StreamingServer(static function (\Psr\Http\Message\RequestInterface $request) use (&$counter) {
    $counter += 1;
    return new Response(
        200,
        [
            'Content-Type' => 'text/plain; charset=utf-8'
        ],
        sprintf("Hey you are %d hit", $counter)
    );
});

$socket = new React\Socket\Server('tcp://0.0.0.0:8888', $loop, ['backlog' => 100000]);
$server->listen($socket);
$loop->run();