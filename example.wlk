class ElementoAtacadoPorPlaga{
  method esBuenoParaLaVida() {}
}

class Hogar inherits ElementoAtacadoPorPlaga{
  var nivelDeMugre = 0
  var confort

  override method esBuenoParaLaVida(){
    return nivelDeMugre <= (confort.div(2))
  }
  method aumentarNivelDeMugre(numero){
    nivelDeMugre += numero
  }  
  method mugre() = nivelDeMugre
}

class Huerta inherits ElementoAtacadoPorPlaga{
  var capacidadDeProduccion
  var nivel

  override method esBuenoParaLaVida(){
    return capacidadDeProduccion > nivel
  }
  method reduccionDeProduccion(numero){
    capacidadDeProduccion -= numero
  }
  method produccion() = capacidadDeProduccion
}

class Mascota inherits ElementoAtacadoPorPlaga{
  var nivelDeSalud = 250

  override method esBuenoParaLaVida(){
    return nivelDeSalud > 250
  }
  method reduccionDeVida(numero){
    nivelDeSalud -= numero 
  }
  method vida() = nivelDeSalud
}

class Barrio{
  const elementos = []

  method agregarElemento(unElemento){
    elementos.add(unElemento)
  }
  method elementosBuenos(){
    return elementos.filter({e => e.esBuenoParaLaVida()})
  }
  method elementosNoBuenos(){
    return elementos.filter({e => not e.esBuenoParaLaVida()})
  }
  method esCopado(){
    return self.elementosBuenos().size() > self.elementosNoBuenos().size()
  }
}

class Plaga{
  var poblacion

  method nivelDeDanio()
  method trasmitenEnfermedades() = poblacion >= 10
  method atacarAElemento(unElemento){
    if(unElemento.identity() == Hogar){
      unElemento.aumentarNivelDeMugre(self.nivelDeDanio())
    } else if(unElemento.identity() == "Huerta"){
      if(self.trasmitenEnfermedades()){
        unElemento.reduccionDeProduccion(self.nivelDeDanio() * 0.1 + 10)
      } else{
        unElemento.reduccionDeProduccion(self.nivelDeDanio() * 0.1)
      }
    } else{
      if(self.trasmitenEnfermedades()){
        unElemento.reduccionDeVida(self.nivelDeDanio())
      }
    }
  }
}

class Cucaracha inherits Plaga{
  const pesoPromedio 

  override method nivelDeDanio(){
    return poblacion.div(2)
  }
  override method trasmitenEnfermedades(){
    return super() and pesoPromedio >= 10 
  }
}

class Pulga inherits Plaga{
  override method nivelDeDanio(){
    return poblacion * 2
  }
}

class Garrapata inherits Pulga{}

class Mosquito inherits Plaga{
  override method nivelDeDanio(){
    return poblacion
  }
  override method trasmitenEnfermedades(){
    return poblacion % 3 == 0
  }
}

