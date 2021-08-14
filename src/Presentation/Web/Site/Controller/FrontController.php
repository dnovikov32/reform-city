<?php

declare(strict_types=1);

namespace App\Presentation\Web\Site\Controller;

use Symfony\Component\HttpFoundation\Request;

class FrontController
{
    public function __invoke(Request $request)
    {
        dd('ololo', $request);
    }

}
