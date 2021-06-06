<?php

declare(strict_types=1);

namespace App\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;

class DefaultController extends AbstractController
{
    /**
     * @Route(
     *     "/{reactRouting}",
     *     name="index",
     *     requirements={"reactRouting"="^(?!api).+"},
     *     defaults={"reactRouting": null}
     * )
     * @Template("base.html.twig")
     * @phpstan-ignore-next-line
     * @return array
     */
    public function defaultAction(): array
    {
        return [];
    }
}
