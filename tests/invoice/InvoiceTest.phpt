<?php

use \Tester\Assert;

require __DIR__ ."/../bootstrap.php";

$xml = new DOMDocument;
$xml->load(__DIR__ . '/invoice-s3.xml');

$xsl = new DOMDocument;
$xsl->load(__DIR__ . '/../../xslt/invoice.xslt');

$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl);

$result = $proc->transformToDoc($xml);
$result->formatOutput = true;

Assert::matchFile(__DIR__. "/invoice-s4.xml", $result->saveXml());
