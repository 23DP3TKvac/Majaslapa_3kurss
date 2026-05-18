<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Favorite extends Model
{
    protected $fillable = ['user_id', 'medicine_id'];

    public function medicine()
    {
        return $this->belongsTo(Medicine::class);
    }
}
