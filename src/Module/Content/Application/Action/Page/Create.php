<?php

declare(strict_types=1);


namespace App\Module\Content\Application\Action\Page;


class Create
{

    public function action()
    {
        return $this->responseJson(
            $this->responseTransformer->transform(
                $this->createPageService->createPage(
                    $this->requestTransformer->transform(
                        $this->request->getQueryParams()
                    )
                )
            )
        );
    }

}
