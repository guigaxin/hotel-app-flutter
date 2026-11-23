import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const TelaPrincipal(),
    ));

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final List hospedes = [
    {'hospede': 'Marina', 'quarto': '204', 'tipo': 'Duplo'}
  ];

  void abrirFormulario({Map? item, int? index}) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TelaFormulario(item: item)),
    );

    if (resultado != null) {
      setState(() {
        index != null ? hospedes[index] = resultado : hospedes.add(resultado);
      });
    }
  }

  void excluir(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Remover registro'),
        content: Text('Excluir ${hospedes[index]['hospede']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() => hospedes.removeAt(index));
              Navigator.pop(context);
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      appBar: AppBar(
        title: const Text('Controle de Hóspedes', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal.shade700,
      ),
      body: hospedes.isEmpty
          ? const Center(child: Text('Nenhum hóspede cadastrado.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: hospedes.length,
              itemBuilder: (_, index) {
                final h = hospedes[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal.shade100,
                      child: Text(h['quarto'], style: TextStyle(color: Colors.teal.shade900, fontWeight: FontWeight.bold)),
                    ),
                    title: Text(h['hospede'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Quarto ${h['quarto']} • ${h['tipo']}'),
                    onTap: () => abrirFormulario(item: h, index: index),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => excluir(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => abrirFormulario(),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Novo'),
      ),
    );
  }
}

class TelaFormulario extends StatefulWidget {
  final Map? item;
  const TelaFormulario({super.key, this.item});

  @override
  State<TelaFormulario> createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  final formKey = GlobalKey<FormState>();
  final nomeCtrl = TextEditingController();
  final quartoCtrl = TextEditingController();
  final tipoCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      nomeCtrl.text = widget.item!['hospede'];
      quartoCtrl.text = widget.item!['quarto'];
      tipoCtrl.text = widget.item!['tipo'];
    }
  }

  void salvar() {
    if (formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'hospede': nomeCtrl.text.trim(),
        'quarto': quartoCtrl.text.trim(),
        'tipo': tipoCtrl.text.trim(),
      });
    }
  }

  String? validar(String? v) => (v == null || v.trim().isEmpty) ? 'Campo obrigatório' : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Novo Hóspede' : 'Editar Hóspede', style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nomeCtrl,
                decoration: const InputDecoration(labelText: 'Hóspede', border: OutlineInputBorder()),
                validator: validar,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: quartoCtrl,
                decoration: const InputDecoration(labelText: 'Quarto', border: OutlineInputBorder()),
                validator: validar,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: tipoCtrl,
                decoration: const InputDecoration(labelText: 'Tipo de acomodação', border: OutlineInputBorder()),
                validator: validar,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: ['Simples', 'Duplo', 'Suíte'].map((t) {
                  return ActionChip(
                    label: Text(t),
                    onPressed: () => setState(() => tipoCtrl.text = t),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: Colors.teal.shade700),
                  onPressed: salvar,
                  child: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}