<?php

declare(strict_types=1);


namespace App\Module\Content\Domain\Page\Assembler\In;


use App\Module\Content\Domain\Page\Dto\PageCreateDto;

class PageCreateDtoAssembler
{
    public function transform()
    {
        return new PageCreateDto();
    }
}
