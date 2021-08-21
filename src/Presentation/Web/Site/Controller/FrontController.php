<?php

declare(strict_types=1);

namespace App\Presentation\Web\Site\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\HttpKernelInterface;

class FrontController extends AbstractController
{
    private HttpKernelInterface $httpKernel;

    /**
     * @param HttpKernelInterface $httpKernel
     */
    public function __construct(HttpKernelInterface $httpKernel)
    {
        $this->httpKernel = $httpKernel;
    }

    public function __invoke(Request $request)
    {
        dd('ololo', $request);
//        $url = ($getUrlBySlug)($request->attributes->get('slug'));

        $this->httpKernel->handle('test');

    }

}
