<?php
namespace Example\Test;
use Facebook\WebDriver\WebDriverBy;

/**
 * Example functional test.
 *
 * @package ace
 * @group   specification
 */ 
class Example_FunctionalTest extends ExampleWebTestCase
{
    /** 
     * Test homepage goes to projects page.
     *
     */
    public function testHomepageProjects()
    {

        # Get homepage url.
        $this->driver->get('http://docs.seleniumhq.org/');
        
        # Click projects menu link.
        $link = $this->driver->findElement(
            WebDriverBy::id('menu_projects')
        );
        $link->click();
 
        # Assert projects url.
        $this->assertSame(
            'http://docs.seleniumhq.org/projects/', 
            $this->driver->getCurrentURL()
        );

    }
}