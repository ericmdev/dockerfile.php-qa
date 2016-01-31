<?php
namespace Example\Test;
use Facebook\WebDriver\Remote\RemoteWebDriver;
use Facebook\WebDriver\Remote\DesiredCapabilities;
use PHPUnit_Framework_TestCase;

/**
 * Example web test case.
 *
 * @package ace
 */ 
abstract class ExampleWebTestCase extends PHPUnit_Framework_TestCase
{
    /** 
     * @var WebDriver
     */
    protected $driver;
 
    /** 
     * Set Up.
     *
     */
    public function setUp() {
        parent::setUp();
        $host = 'http://localhost:4444/wd/hub'; // this is the default
        $capabilities = DesiredCapabilities::firefox();
        $this->driver = RemoteWebDriver::create($host, $capabilities, 35000);
    }
 
    /** 
     * Tear Down.
     *
     */
    public function tearDown() {
 
        $this->driver->quit();
        parent::tearDown();
    }
}