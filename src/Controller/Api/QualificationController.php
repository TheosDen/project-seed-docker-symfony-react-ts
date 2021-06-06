<?php

declare(strict_types=1);

namespace App\Controller\Api;

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
        $data = [
            [
                'id' => 1,
                'customer_id' => 1,
                'description' => 'Accuracy',
            ],
            [
                'id' => 2,
                'customer_id' => 1,
                'description' => 'Integrity',
            ],
            [
                'id' => 3,
                'customer_id' => 1,
                'description' => 'Scientific aptitude',
            ],
            [
                'id' => 4,
                'customer_id' => 1,
                'description' => 'Mathematical skills',
            ],
            [
                'id' => 5,
                'customer_id' => 1,
                'description' => 'Interpersonal skills',
            ],
        ];

        $view = $this->view($data, 200);

        return $this->handleView($view);
    }
}
