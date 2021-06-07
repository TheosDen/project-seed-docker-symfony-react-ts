<?php

declare(strict_types=1);

namespace App\Controller\Api;

use App\Entity\Qualification;
use FOS\RestBundle\Controller\AbstractFOSRestController;
use FOS\RestBundle\Controller\Annotations as Rest;
use Symfony\Component\HttpFoundation\Response;

class QualificationController extends AbstractFOSRestController
{
    /**
     * @Rest\Get(path="/api/qualification")
     * @return Response
     */
    public function getQualificationsAction(): Response
    {
        $list = $this->getDoctrine()
            ->getRepository(Qualification::class)
            ->findAll();

        $view = $this->view($list, 200);

        return $this->handleView($view);
    }
}
