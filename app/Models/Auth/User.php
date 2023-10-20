<?php
namespace App\Models\Auth;

use App\Models\TConsulting\Empleado;
use App\Models\Tconsulting\Empresa;
use App\Notifications\ResetPasswordNotification;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    use Notifiable;
    protected $hidden  = ['password', 'remember_token'];
    protected $guarded = ['id'];
    protected $casts   = [
        'active' => 'boolean',
    ];

    public function sendPasswordResetNotification($token)
    {
        $this->notify(new ResetPasswordNotification($token));
    }

    public function roles()
    {
        return $this->belongsToMany(Role::class, 'user_roles');
    }

    public function roleIds()
    {
        return $this->roles->pluck('id')->toArray();
    }

    public function empleado()
    {
        return $this->hasOne(Empleado::class, 'cue', 'cue');
    }

    public function empresa()
    {
        return $this->hasOne(Empresa::class, 'id', 'empresa_id');
    }
}