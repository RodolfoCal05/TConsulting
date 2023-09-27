<?php

namespace App\Models\Tconsulting;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Empresa extends Model
{
    protected $table = 'empresas';
    protected $guarded = ['id'];
    public $timestamps = true;
}
