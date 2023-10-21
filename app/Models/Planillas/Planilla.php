<?php

namespace App\Models\Planillas;

use App\Models\Tconsulting\Empresa;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Planilla extends Model
{
    protected $table = 'planillas';
    protected $primaryKey = 'id';
    //protected $guarded = ['id'];
    public $timestamps = true;

    public function tipo(){
        return $this->hasOne(TipoPlanilla::class, 'id', 'tipo_planilla_id');    
    }

    public function empresa(){
        return $this->hasOne(Empresa::class, 'id', 'empresa_id');    
    }

}
