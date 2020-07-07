class Alumno
	attr_accessor :grado, :dni, :nombre, :apellidos, :fechanacimiento, :genero, :colegioprocedencia, :promedio, :dniapode, :nomapode, :ingapode
	def initialize(grado,dni,nombre,apellidos,fechanacimiento,genero,colegioprocedencia,promedio,dniapode,nomapode,ingapode)
		@grado=grado
		@dni=dni
		@nombre=nombre
		@apellidos=apellidos
		@fechanacimiento=fechanacimiento
		@genero=genero
		@colegioprocedencia=colegioprocedencia
		@promedio=promedio
		@dniapode=dniapode
		@nomapode=nomapode
		@ingapode=ingapode
	end

	def crearcodigo
		case grado
			when 'P'
				return 'P'+(dni).to_s
			when 'S'
				return 'S'+(dni).to_s
		end
	end

	def calcularmatricula
		case grado
		when 'P'
			pago=300
		when 'S'
			pago=400
		end
	end

	def calcularmensualidad
		case grado
		when 'P'
			pago= 550
		when 'S'
			pago= 650
		end

		if ingapode>=850 and ingapode<1200
			pago=pago*0.90
		else if ingapode>=1200 and ingapode<1800
				pago=pago*0.93
			else if ingapode>=1800
					pago=pago*0.95
				end
			end
		end
	end
end

class Nuevos < Alumno
	def initialize(grado,dni,nombre,apellidos,fechanacimiento,genero,colegioprocedencia,promedio,dniapode,nomapode,ingapode)
		super(grado,dni,nombre,apellidos,fechanacimiento,genero,colegioprocedencia,promedio,dniapode,nomapode,ingapode)
	end

	def calcularmatricula
		case grado
		when 'P'
			valor=300*0.05
		when 'S'
			valor=400*0.05
		end
		super-valor
	end

	def calcularmensualidad
		super
	end
end

class Antiguos < Alumno
attr_accessor :promedio
	def initialize(grado,dni,nombre,apellidos,fechanacimiento,genero,colegioprocedencia,promedio,dniapode,nomapode,ingapode)
		super(grado,dni,nombre,apellidos,fechanacimiento,genero,colegioprocedencia,promedio,dniapode,nomapode,ingapode)
	end

	def calcularmatricula
		case grado
			when 'P'
				valor=300*0.10
			when 'S'
				valor=400*0.10
		end
		super-valor
	end

	def calcularmensualidad
		case grado
		when 'P'
			valor= 550
		when 'S'
			valor= 650
		end
		if promedio>=17
			valor=valor*0.20
		else if promedio>=15  
				if promedio<17
					valor=valor*0.10
				end
			else
				valor=0
			end
		end
		super-valor
	end
end

class AlumnoView

	def calcularcantidadalumnos(alumnos)
		puts "--------------------------------------------------------------------------------------"
		puts "CANTIDAD DE ALUMNOS MATRICULADOS EN EL COLEGIO"
		puts "La cantidad de alumnos matriculados es de: "+(alumnos.size).to_s
		puts " "
	end

	def listaralumnos(alumnos)
		puts "--------------------------------------------------------------------------------------"
		puts "Los matriculados en el colegio son: "
		puts " "
		puts "CODIGO      NOMBRE    APELLIDO  GRADO         FECH. NACIMIENTO    SEXO    COLEGIO ANTERIOR   PROMEDIO   APODERADO"
		for i in 0..alumnos.size-1
			print (alumnos[i].crearcodigo).ljust(12)
			print (alumnos[i].nombre).ljust(10)
			print (alumnos[i].apellidos).ljust(10)
			case alumnos[i].grado
			when 'P'
				print ("Primaria").ljust(14)
			when 'S'
				print ("Secundaria").ljust(14)
			end
			print (alumnos[i].fechanacimiento).ljust(20)
			print (alumnos[i].genero).ljust(8)
			print (alumnos[i].colegioprocedencia).ljust(19)
			print (alumnos[i].promedio.to_s).ljust(11)
			print (alumnos[i].nomapode)
			puts " "
		end
		puts "--------------------------------------------------------------------------------------"
	end

	def presupuestoalumno(alumnos)
		puts "Los pagos realizados al año por los alumnos son:"
		puts " "
		puts "ALUMNO              MATRICULA    MENSUALIDAD   TOTAL ANUAL"
		for i in 0..alumnos.size-1
			print ((alumnos[i].nombre)+" "+(alumnos[i].apellidos)).ljust(20)
			print ((alumnos[i].calcularmatricula).round(0).to_s).ljust(13)
			print ((alumnos[i].calcularmensualidad).round(1).to_s).ljust(14)
			print ((alumnos[i].calcularmatricula+alumnos[i].calcularmensualidad*11)).round(1).to_s
			puts " "
		end
		puts "--------------------------------------------------------"
	end

	def buscaralumno(alumnos,dni)
		puts "BUSQUEDA DE ALUMNOS POR SU NUMERO DE DNI"
		estado='n'
		for i in 0..alumnos.size-1
			if dni == alumnos[i].dni
				estado= 's'
				encontrado=i
			end
		end
		case estado
			when 's'
				puts "Se encontro al alumno con DNI #{alumnos[encontrado].dni} a"
				puts "DNI         NOMBRE    APELLIDO  GRADO         FECH. NACIMIENTO  GENERO  COLEGIO ANTERIOR   PROMEDIO   NOM.APODERADO"
				print (alumnos[encontrado].dni).ljust(12)
				print (alumnos[encontrado].nombre).ljust(10)
				print (alumnos[encontrado].apellidos.to_s).ljust(10)
				case alumnos[encontrado].grado
				when 'P'
					print ("Primaria").ljust(14)
				when 'S'
					print ("Secundaria").ljust(14)
				end
				print (alumnos[encontrado].fechanacimiento).ljust(18)
				print (alumnos[encontrado].genero).ljust(8)
				print (alumnos[encontrado].colegioprocedencia).ljust(19)
				print (alumnos[encontrado].promedio.to_s).ljust(11)
				print (alumnos[i].nomapode)
				puts " "
				puts " "
			when 'n'
				puts "No se encontró al alumno con DNI "+(dni).to_s
				puts " "
		end
	end

	def buscarapoderado(alumnos,dni)
		puts "BUSQUEDA DE APODERADOS POR SU NUMERO DE DNI"
		estado='n'
		for i in 0..alumnos.size-1
			if dni == alumnos[i].dniapode
				estado= 's'
				encontrado=i
			end
		end
		case estado
			when 's'
				puts "Se encontro al apoderado con DNI #{alumnos[encontrado].dniapode} a"
				puts "DNI         NOMBRE    INGRESOS"
				print (alumnos[encontrado].dniapode).ljust(12)
				print (alumnos[encontrado].nomapode).ljust(10)
				print (alumnos[encontrado].ingapode.to_s).ljust(10)
				puts " "
				print "A cargo de "
				print (alumnos[encontrado].nombre)
				print " esta en "
				case alumnos[encontrado].grado
				when 'P'
					print ("Primaria")
				when 'S'
					print ("Secundaria")
				end
				print " del genero "
				print (alumnos[encontrado].genero)
				print " y proviene del colegio "
				print (alumnos[encontrado].colegioprocedencia)
				puts " "
				puts " "
			when 'n'
				puts "No se encontró al apoderado con DNI "+dni
				puts " "
		end
	end
end

class AlumnoController
	attr_accessor :alumnos
	def initialize
		@alumnos=Array.new
		@alumnoview=AlumnoView.new
	end

	def adicionar(tipo,grado,dni,nombre,apellidos,fechanacimiento,genero,colegioprocedencia,promedio,dniapode,nomapode,ingapode)
		case tipo
			when 1
				postula=Nuevos.new(grado,dni,nombre,apellidos,fechanacimiento,genero,colegioprocedencia,promedio,dniapode,nomapode,ingapode)
			when 2
				postula=Antiguos.new(grado,dni,nombre,apellidos,fechanacimiento,genero,colegioprocedencia,promedio,dniapode,nomapode,ingapode)
		end
		alumnos.push(postula)
	end

	def apoderadodni(nombre)
			clave=0
			while clave==0
				puts "Ingrese su DNI(8 digitos) el apoderado de #{nombre}"
				x=gets.chomp
				if x.size<8
					puts "Cantidad inferior de digitos, escriba 8 digitos"
				else if x.size>8
					puts "Cantidad superior de digitos, escriba 8 digitos"
					else
						clave=1
					end
				end
			end
		return x
	end

	def apoderadonom(nombre)
		puts "Ingrese su nombre el apoderado de #{nombre}"
		x=gets.chomp
		return x
	end

	def apoderadoing(nombre)
		x=0
			clave=0
			while clave==0
				puts "Ingrese el valor de sus ingresos el apoderado de #{nombre}"
				x=gets.to_i
				if x==0
					puts "El valor de sus ingresos no puede ser 0"
				else if x<=850
					puts "El valor de sus ingresos tiene que ser mayor o igual que 850"
					else
						clave=1
					end
				end
			end
		return x
	end

	def entrada
		nombres=["Miguel","Luis","Maritza","Tonio","Javiera","Nancy"]
		postulante=AlumnoController.new
		apodedni=[]
		apodenom=[]
		apodeing=[]
		for i in 0..nombres.size-1
			apodedni[i]=postulante.apoderadodni(nombres[i])
			apodenom[i]=postulante.apoderadonom(nombres[i])
			apodeing[i]=postulante.apoderadoing(nombres[i])
		end
		postulante.adicionar(1,'S',"12345678",nombres[0],"Ruiz","07/11/2006",'M',"SAN PEDRO",14,apodedni[0],apodenom[0],apodeing[0])
		postulante.adicionar(2,'P',"65832159",nombres[1],"Jaio","15/05/2010",'M',"TRILCE",16.3,apodedni[1],apodenom[1],apodeing[1])
		postulante.adicionar(1,'P',"54785692",nombres[2],"Melania","28/07/2009",'F',"MALVINAS",15.5,apodedni[2],apodenom[2],apodeing[2])
		postulante.adicionar(1,'S',"54785692",nombres[3],"Torres","12/09/2007",'M',"MASTERS",19.2,apodedni[3],apodenom[3],apodeing[3])
		postulante.adicionar(2,'S',"13164952",nombres[4],"Jiron","23/12/2008",'F',"SAGRADOS",14.9,apodedni[4],apodenom[4],apodeing[4])
		postulante.adicionar(2,'P',"85975862",nombres[5],"Patriot","01/01/2011",'F',"SAN JUDAS",17.6,apodedni[5],apodenom[5],apodeing[5])
		postulante.procesar
		postulante.procesarbusquedaalumno("13164952")
		postulante.procesarbusquedaalumno("35128469")
		postulante.procesarbusquedaapoderado("12345678")
		postulante.procesarbusquedaapoderado("87654321")
	end

	def procesar
		@alumnoview.calcularcantidadalumnos(alumnos)
		@alumnoview.listaralumnos(alumnos)
		@alumnoview.presupuestoalumno(alumnos)
	end

	def procesarbusquedaalumno(dni)
		@alumnoview.buscaralumno(alumnos,dni)
	end

	def procesarbusquedaapoderado(dni)
		@alumnoview.buscarapoderado(alumnos,dni)
	end
end

postulante=AlumnoController.new
postulante.entrada